From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [PATCH 0/7] Detaching fbcon
Date: Mon, 12 Jun 2006 09:49:50 +0200
Message-ID: <448D1C9E.7050606@t-online.de>
References: <44856223.9010606@gmail.com> <448C19D7.5010706@t-online.de>
	<448C83AD.9060200@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fph9p-0005iK-KI for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 00:48:21 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fph9p-0006Zx-8c for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 00:48:21 -0700
Received: from mailout11.sul.t-online.com ([194.25.134.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fph9o-00074W-TZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 00:48:21 -0700
In-Reply-To: <448C83AD.9060200@gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Hi Tony,

>We'll use fb_restore_state and fb_save_state if available, yes, but I don't
>think we need to implement unbind and bind.  For one, as Jon and Andrew
>has pointed out, drivers should have no concept of binding. (That's why the
>patch has escalated to VT binding).
>
>  =

>
Well, it does not matter if it=B4s the fbcon or vt layer that does the
binding. I agree with Jon and Andrew that vt binding is the better
way.

>And why force drivers to have an fb_restore_state/fb_save_state just to
>unbind/bind?  This is going to penalize 10's of drivers that don't need
>it.  Just make this feature an experimental kconfig option, or make this
>available as a boot option.
>  =

>
An experimental feature could be "Allow all framebuffer drivers to unbind".
Non-experimental behaviour really should be to allow unbinding
only if the framebuffer driver allows it. The fbcon and vt layer simply
does not know if it is safe, and thus they have to interrogate the
hardware layer that knows the answer.

Your current proposal is to allow unbinding and removal of the framebuffer
driver and the fbcon layer, no matter what the result will be. I don=B4t th=
ink
that this is ok.  There is  John User that tries to switch to text mode, and
he will complain if it does leave his hardware in an unusable state.

I suggest to add the fb_unbinding / fb_binding fbops and to only allow
unbinding if we know that it will not leave the video hardware in a state
that is unusable for proper operation.

If there is nothing to be done inside those two fbops, they simply return
0.

Other framebuffer drivers set the hardware to a state that is completely
unusable by a textmode console and that is incompatible with X. These
might need to know if X is active to decide if unbinding makes any sense at
that specific moment. They can know that by adding the save/restore_state
fbops. No, I don=B4t think that the save/restore_state fbops should be =

required
for unbinding operations, I think you misunderstood me in that place.

cu,
 knut
