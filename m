From: Aleksandr Koltsoff <czr@iohazard.tts.fi>
Subject: Re: Programming advanced hardware in 69030
Date: Fri, 4 Jul 2003 12:34:18 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030704093418.GA21481@iohazard.tts.fi>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iohazard.tts.fi ([194.100.228.154])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19YMy5-00040F-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 04 Jul 2003 02:35:01 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nitin@soc-soft.com
Cc: linux-fbdev-devel@lists.sourceforge.net

Hello Nitin

Get the programming documentation from asiliant website (it's all free and
released).

I do not understand your version of "hotswapping"? If you mean
hotswapping the whole graphics unit then that's beyond the chips
capabilities, but is the problem of the system motherboard and
supporting chips there. If you mean hotswapping the monitor/lcd-stuff
on the fly that can be done by reading how to get ddc and interrupt
data from the chip (get the documentation).

As what comes to accessing frame buffer memory into pages, that is too
a bit unclear to me. If you mean banked modes and such, you don't want
to do that in any 32-bit processor/OS but rather access all the memory
using linear mapping (it's much simpler).

The accelerator that 69k has is not very capable (compared to many
others), but rather you get somewhat accelerated blits and that's
about all. It's pretty simple unless you end up doing non-MMIO stuff
(again, read the docs).

The multimedia 'engine' is basically just an YUV/RGB conversion unit,
nothing much else. The programming docus tell how to use it, but it
might be not worth it with fast CPUs.

To have FPS 15 you have three options:
- design a modeline for the chip that will output 15 FPS really
  (it will be a slow scan mode so actually you won't see anything much on
  the screen and probably your monitor won't even sync to it)
  (this is not what you want)
- You try to find a mode that is integer multiple of your desired FPS
  In your case 60 Hz, 75 Hz are both multiples. With first, you will
  display new frame every 4th screen refresh, with 75 it's every 5th, I'm
  sure you get the picture.
- You take any mode that is available (doesn't have to be integer multiple,
  and besides, even the integer multiple modes are not accurate (clocks
  drift etc)). You design your frame refresher so that instead of syncing
  against sound, you will sync against a real time hard clock which is
  accurate enough (depends on your hardware whether you have anything
  capable of this). Then you try to fit your video frames as best as possible
  to the refresh rate that you have. If you have a powerful processor you
  might be interested in modifying the framerate using DSP algos too (used
  in converting cinema/NTSC/PAL-rates with high-quality). You audio will also
  be synced against the real hard clock but there you can get away with
  simple linear or bilinear interpolation to adjust for the drops/advances.
  
It all depends on what you want to do.

Hope this helps.

ak.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
