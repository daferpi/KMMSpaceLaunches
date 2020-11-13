package com.daferpi.kmmspacelaunches.shared

import com.daferpi.kmmspacelaunches.shared.cache.Database
import com.daferpi.kmmspacelaunches.shared.cache.DatabaseDriverFactory
import com.daferpi.kmmspacelaunches.shared.entities.RocketLaunch
import com.daferpi.kmmspacelaunches.shared.network.SpaceXApi

class SpaceXSDK(databaseDriverFactory: DatabaseDriverFactory) {
    private val database = Database(databaseDriverFactory)
    private val api = SpaceXApi()

    @Throws(Exception::class) suspend fun getLaunches(forcedReload: Boolean): List<RocketLaunch> {
        val cacheLaunches = database.getAllLaunches()
        return if (cacheLaunches.isNotEmpty() && !forcedReload) {
            cacheLaunches
        } else {
            api.getAllLaunches().also {
                database.clearDatabase()
                database.createLaunches(it)
            }
        }
    }
}