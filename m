From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Another problem, seemingly coming f
Date: Tue, 15 Oct 2002 12:59:28 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4AAC8897E93@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailgw.cvut.cz ([147.32.3.235])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181PQo-0001YL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Oct 2002 04:00:11 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: linux-fbdev-devel@lists.sourceforge.net, gif@bek.no

On 15 Oct 02 at 12:33, Carlo E. Prelz wrote:
> Now that I can see the output of the second card, I have a new
> problem. WIth both versions of the driver, the output on the second
> head is influenced by what is sent to the first head. It is very
> difficult for me to describe, especially because the relative PC is
> very far from me. But I see that, if I set the second head to 16bpp,
> the amount of disruption to it is little if the first head is set to
> 32bpp, medium if set to 16 and very high if the first head is set to
> 8bpp. It seems the info for the first head is spilling to the second
> one. This does not happen if the g400 is by itself, only if the
> Millennium is also present.

> -40: 20 41 04 50 00 3c 00 00 06 ff ff 06 00 00 00 00
> -50: 00 30 00 01 19 a4 90 01 00 00 00 00 00 00 00 00
> +40: 20 00 04 00 00 3c 00 00 2b ff ff 2b 00 00 00 00
> +50: 00 30 00 00 00 00 00 00 00 00 00 00 00 00 00 00

It looks ok - VGA aperture (bit 0 of reg 0x41) is disabled,
so no corruption should occur.

> All the above comes from 2.4.20-pre10-ac2 with your previous
> patch. Can you help again? Any other info that you may need?

By default (after powerup) you'll see garbage on secondary monitors.
They'll be up in 640x480/60Hz, but without usable picture. You
must do 'con2fb /dev/fb1 /dev/tty5' to get usable picture on
screen. And you must boot with 'video=scrollback:0', otherwise
picture will get corrupted if you'll hit 'shift-pgup'. But until
you hit shift-pgup, picture should be ok.
                                                Petr
                                                


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
