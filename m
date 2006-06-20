From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 3/9] VT binding: Make VT binding a
	Kconfig option
Date: Tue, 20 Jun 2006 10:04:06 -0400
Message-ID: <9e4733910606200704n19da7833s6873eb3270fe299e@mail.gmail.com>
References: <44957026.2020405@gmail.com>
	<9e4733910606191718n74d0bf40na7b0cc3902d80172@mail.gmail.com>
	<44974AC7.4060708@gmail.com>
	<9e4733910606191916i1994d4d1i2ea661e015431750@mail.gmail.com>
	<4497B2B5.4040001@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fsgps-0007OC-Ep for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 07:04:08 -0700
Received: from nz-out-0102.google.com ([64.233.162.199])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fsgps-0002tc-4T
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 07:04:08 -0700
Received: by nz-out-0102.google.com with SMTP id z3so132967nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 20 Jun 2006 07:04:07 -0700 (PDT)
In-Reply-To: <4497B2B5.4040001@gmail.com>
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

On 6/20/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> All fbdev drivers have a startup mode that should always be valid. All
> fbcon does is enable that mode.
>
> You can load nvidiafb like this instead:
>
> modprobe nvidiafb mode_option=1024x768@60

Good idea, it didn't occur to me to use the module parameters. Doing
it that way I can see what I am doing instead of typing blind.

> > How does vbetool save state?
>
> vbetool basically calls an int10 function that saves the state.  This
> function is unique per video BIOS, ie you cannot use the state file in
> another machine even if the graphics chipset is the same.
>
> > Could VGAcon do whatever vbetool is doing?
>
> No it can't.  Once the card is in graphics mode, vgacon cannot go to
> text mode on its own.  It has to know how to write to other VGA
> registers which are unique per hardware.

Might be a good place for a little call_usermodehelper example. VGAcon
could try calling vbetool to save it's state and restore it. GregKH
told me that the class firmware loader code was the place to start.

-- 
Jon Smirl
jonsmirl@gmail.com
