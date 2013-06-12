import mx.controls.Alert;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.net.URLRequest;
import flash.events.Event;
import flash.events.ProgressEvent;

public var snd:Sound;
public var channel:SoundChannel;

public function init():void
{
    trace('init');
    snd = new Sound();
    snd.addEventListener(Event.COMPLETE, onSoundComplete);
    snd.addEventListener(Event.OPEN, onSoundOpen);
    snd.addEventListener(ProgressEvent.PROGRESS, onSoundProgress);

}

public function logo_click(event:Event):void
{
    trace('clicked on image');
}

public function onSoundComplete(event:Event):void
{
    trace("on sound complete");
}

public function onSoundProgress(event:ProgressEvent):void
{
    trace('on sound progress');
    var loadTime:Number = event.bytesLoaded / event.bytesTotal;
    var LoadPercent:uint = Math.round(100 * loadTime);

    trace(LoadPercent);
}


public function onSoundOpen(event:Event):void
{
    trace('on sound open');
}

public function play():void 
{
    trace('play');
    var req:URLRequest = new URLRequest('https://copy.com/PxZJio6DebewJtx3/test.mp3?download=1');
    snd.load(req);
    channel = snd.play();

    addEventListener(Event.ENTER_FRAME, onEnterFrame);
    channel.addEventListener(Event.SOUND_COMPLETE, onPlaybackComplete); 
}

public function onEnterFrame(event:Event):void
{
    trace('on enter frame');

    var estimatedLength:int =  
        Math.ceil(snd.length / (snd.bytesLoaded / snd.bytesTotal)); 
    var playbackPercent:uint =  
        Math.round(100 * (channel.position / estimatedLength)); 
    trace("Sound playback is " + playbackPercent + "% complete."); 
    bar.setProgress(playbackPercent, 100);
}

public function onPlaybackComplete(event:Event):void
{
    trace("The sound has finished playing."); 
    removeEventListener(Event.ENTER_FRAME, onEnterFrame); 
}
