

mob
	proc
		setVolume(direction, track)
			switch(track)
				if("MUSIC")
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
				if("SFX")
					switch(direction)
						if("UP")
							SFX_VOLUME+=5
							if(SFX_VOLUME>=100) SFX_VOLUME=100
							return
						else
							SFX_VOLUME-=5
							if(SFX_VOLUME<=0) SFX_VOLUME=0
							return


var/sound/MENU = sound('Music/SPC-Menu.ogg',1, channel=2, volume=20)

