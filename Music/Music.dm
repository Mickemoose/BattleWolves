

mob
	proc
		setVolume(direction)
			switch(direction)
				if("UP")
					MUSIC_VOLUME+=5
					if(MUSIC_VOLUME>=100) MUSIC_VOLUME=100
					SongPlaying.volume = MUSIC_VOLUME
					SongPlaying.status = SOUND_UPDATE
					src<<SongPlaying
					return
				else
					MUSIC_VOLUME-=5
					if(MUSIC_VOLUME<=0) MUSIC_VOLUME=0
					SongPlaying.volume = MUSIC_VOLUME
					SongPlaying.status = SOUND_UPDATE
					src<<SongPlaying
					return


var/sound/MENU = sound('Music/SPC-Menu.ogg',1, channel=2, volume=MUSIC_VOLUME)

