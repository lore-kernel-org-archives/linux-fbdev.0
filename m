From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Another problem, seemingly coming f
Date: Tue, 15 Oct 2002 17:36:58 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4AF682A487A@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailgw.cvut.cz ([147.32.3.235])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181Tl8-00039T-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Oct 2002 08:37:27 -0700
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
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: linux-fbdev-devel@lists.sourceforge.net, gif@bek.no

On 15 Oct 02 at 17:04, Carlo E. Prelz wrote:
> 
> Having spent the last hours doing tests, I return to you with the
> exact certainty that the two displays of the G400 work perfectly when
> the millennium card is not present, but the second head of the G400
> starts to misbehave when the millennium card is inserted.

I have no idea. Can you try patching your kernel with
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/fbset-through-vt-2.4.19-rc5.gz?
(if you are using 2.5.x, I can send you patch on request). 
Maybe you'll get an 'Crossdevice link' error on some of your
fbset commands.

> Here is my methology: for each head I first call 
> 
> fbset -fb /dev/fbX 800x600-60 -depth 32 

Always make sure that you are running fbset on foreground device.
Otherwise bad things will happen.
 
> When I run fbset on /dev/fb1 (first head of g400) the output of the
> second head is corrupted. Moving diagonal bands appear. The situation
> does not change when the image is copied to the first head. The image
> on the G400's first head as well as that on the millennium is
> perfect. 

If you'll read contents of /dev/fb2 and put it to /dev/fb1, is this
picture correct or not?
 
> I am attaching a small jpeg that shows the three monitors (this is
> from a remote webcam and is all I also can see from the screens) when
> the image that I am attaching has been sent to all three

Unfortunately I do not see anything. I see horizontal black lines
on all three monitors, and nothing else...
 
> monitors. Monitors are, in order, first and second head of G400, and
> millennium. You can see the diagonal bands on the central screen.

Can you try 
'matroxset -f /dev/fb2 -m 0'
'matroxset -f /dev/fb1 -m 3'
Now both G400 monitor should show same picture. If they do not, problem
is in secondary output path... (I'd like to know where...).
'matroxset -f /dev/fb1 -m 0'
'matroxset -f /dev/fb2 -m 3'
Now both outputs are driven by secondary head, /dev/fb2...
'matroxset -f /dev/fb2 -m 1'
'matroxset -f /dev/fb1 -m 2'
Now both outputs are swapped: /dev/fb1 drives secondary monitor,
and /dev/fb2 primary.
'matroxset -f /dev/fb1 -m 0'
'matroxset -f /dev/fb2 -m 2'
'matroxset -f /dev/fb1 -m 1'
And now it is back in initial state...

Maybe it is some poweron initialization problem of Maven. Can you ask
your friend on the remote site to go into the BIOS, and select 'AGP'
as primary device in the BIOS? Then G400 will be initialized by BIOS,
and Millennium by matroxfb. Maybe it will make things better.
                                                        Petr
                                                        


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
