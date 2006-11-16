From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC 2.6.18.1 1/1] Framebuffer driver for
 Hecuba/E-Ink display
Date: Thu, 16 Nov 2006 02:40:59 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0611160239180.16998@pademelon.sonytel.be>
References: <45a44e480611142315k33d8df02y73f73ce9b3a3b111@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1793497824-1163641259=:16998"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GkWFd-00037j-0N for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Nov 2006 17:41:13 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GkWFb-0002Ej-G2
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Nov 2006 17:41:12 -0800
Received: from pademelon.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 9EEC058C32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 16 Nov 2006 02:40:59 +0100 (MET)
In-Reply-To: <45a44e480611142315k33d8df02y73f73ce9b3a3b111@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1793497824-1163641259=:16998
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Nov 2006, Jaya Kumar (=E0=AE~\=E0=AF~F=E0=AE=AF=E0=AE=BE=E0=AE=
~U=E0=AF~A=E0=AE=AE=E0=AE=BE=E0=AE=B0=E0=AF~M) wrote:
> By the way, I have been wondering about the possibility of
> implementing a nopage type handler in order to provide a fake mmap for
> this class of IO driven fb devices (as opposed to memory driven
> devices). This would allow apps that are entirely mmap driven to still
> use IO based fb devices. To elaborate, it would be along the lines of:
> - like regular drivers, IO fb drivers would setup an mmap handler
> - in the mmap handler, rather than do remap_pfn_range, an IO fb driver
> would setup a custom vm_ops for this vma range
> - a userspace app like Xorg or others start a burst of display
> updates. this writes to this address for the first time, so our
> vma->vm_ops->nopage would get called
> - in this nopage, we would kick off a workqueue task or a timer, say
> deferred_fb_io().  we map a regular page and the app and other apps
> are free to cheaply write to this memory without the expense of the IO
> backed fb
> - before the workqueue or timer expires, the apps would be writing to
> memory and no fb updates would be occuring
> - then when the workqueue kicks in or the timer expires, we do an fb
> update (either partial by differencing or a full update). then we
> unmap the pte
> - therefore when the next burst of display updates occur, this page
> fault driven sequence is repeated
>=20
> The benefit of this would be that bursts of display updates would not
> cause bursts of repeated IO. I think this would also provide an
> ability to have a minimum latency within which display updates can be
> expected to occur. Please let me know if this sounds reasonable.

Yep, sounds like a nice idea to try, and compare with other methods, like=
 e.g.
copying the frame buffer to the external device every vsync.

But I guess the `every vsync' is not a good idea for e-ink, as it's very =
slow
to update?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. =
But
when I'm talking to journalists I just say "programmer" or something like=
 that.
							    -- Linus Torvalds
---584337861-1793497824-1163641259=:16998
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
---584337861-1793497824-1163641259=:16998
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---584337861-1793497824-1163641259=:16998--
