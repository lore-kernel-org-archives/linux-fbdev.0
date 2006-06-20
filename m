From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 3/9] VT binding: Make VT binding a
	Kconfig option
Date: Mon, 19 Jun 2006 22:16:33 -0400
Message-ID: <9e4733910606191916i1994d4d1i2ea661e015431750@mail.gmail.com>
References: <44957026.2020405@gmail.com>
	<9e4733910606191718n74d0bf40na7b0cc3902d80172@mail.gmail.com>
	<44974AC7.4060708@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FsVn9-0004AV-D1 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jun 2006 19:16:35 -0700
Received: from nz-out-0102.google.com ([64.233.162.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FsVn9-0001fg-3B
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jun 2006 19:16:35 -0700
Received: by nz-out-0102.google.com with SMTP id z3so20048nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 19 Jun 2006 19:16:34 -0700 (PDT)
In-Reply-To: <44974AC7.4060708@gmail.com>
Content-Disposition: inline
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On 6/19/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jon Smirl wrote:
> > I gave this patch a try and it seems to work. I say seems because I
> > could not get the nvidiafb driver to set a usable mode after it was
> > bound/unbound.
>
> What do you mean by this?  You mean that you cannot restore vgacon?
> If that's the case, then yes, that is perfectly understandable as
> nvidiafb does not restore VGA to text mode.

modprobe fbcon
modprobe nvidiafb

Display is messed up.

I used to fix this by switching to X and back but the nvidia X driver
won't build on the mm kernel. I can try again and write a script to
echo a mode into sysfs after the modprobe.

When fbcon first gets a new fbdev driver registered with it, should it
pick one of the modes is supports and set it automatically?

>  or would it be better for each driver to set in a
> > default mode that it understands when it gets control? The fbdev
> > driver should not set a mode when it loads, but that doesn't mean
> > fbcon can't set one when it is activated. Similarly VGAcon would set
> > the mode (and load its fonts) when it regains control.
>
> The problem with vgacon setting its own mode is that it does not know
> anything about the hardware. So VGA text mode will need to rely on
> a secondary program to set the mode (whether it's vbetool, another
> fb driver, or X does not matter).

How does vbetool save state? Could VGAcon do whatever vbetool is doing?

-- 
Jon Smirl
jonsmirl@gmail.com
