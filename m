From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 3/9] VT binding: Make VT binding a
	Kconfig option
Date: Mon, 19 Jun 2006 20:18:59 -0400
Message-ID: <9e4733910606191718n74d0bf40na7b0cc3902d80172@mail.gmail.com>
References: <44957026.2020405@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FsTxN-00036B-0F for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jun 2006 17:19:01 -0700
Received: from nz-out-0102.google.com ([64.233.162.207])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FsTxM-0008BD-KQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jun 2006 17:19:00 -0700
Received: by nz-out-0102.google.com with SMTP id z3so3933nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 19 Jun 2006 17:18:59 -0700 (PDT)
In-Reply-To: <44957026.2020405@gmail.com>
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

I gave this patch a try and it seems to work. I say seems because I
could not get the nvidiafb driver to set a usable mode after it was
bound/unbound. That's not a problem with the patch, the patch is not
addressing that issue. I tried vbetool but it kept GPFing. This is a
patch to help developers so maybe someone will fix nvidiafb to be more
friendly.

Is there any way to lessen this problem? Would it help if fbcon worked
with text modes, or would it be better for each driver to set in a
default mode that it understands when it gets control? The fbdev
driver should not set a mode when it loads, but that doesn't mean
fbcon can't set one when it is activated. Similarly VGAcon would set
the mode (and load its fonts) when it regains control.

It would also be interesting to make VGAcon a modular driver. You
could build in fbcon and then work on VGAcon.

-- 
Jon Smirl
jonsmirl@gmail.com
