From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] atmel_lcdfb: backlight control
Date: Wed, 23 Jan 2008 14:06:10 -0800
Message-ID: <20080123140610.4509f165.akpm@linux-foundation.org>
References: <4790BB53.3080407@atmel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JHnk4-0006mb-N7 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Jan 2008 14:06:44 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JHnk3-0002T8-7B
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Jan 2008 14:06:44 -0800
In-Reply-To: <4790BB53.3080407@atmel.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: david-b@pacbell.net, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux@maxim.org.za

> On Fri, 18 Jan 2008 15:44:35 +0100 Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> On the sam9 EK boards, the LCD backlight is hooked up to a PWM output
> from the LCD controller.  It's controlled by "contrast" registers though.
> 
> This patch lets boards declare that they have that kind of backlight
> control.  The driver can then export this control, letting screenblank
> and other operations actually take effect ... reducing the typically
> substantial power drain from the backlight.
> 
> +static inline void init_backlight(struct atmel_lcdfb_info *sinfo)
> +static inline void exit_contrast(struct atmel_lcdfb_info *sinfo)
> +static inline void init_backlight(struct atmel_lcdfb_info *sinfo)
> +static inline void exit_contrast(struct atmel_lcdfb_info *sinfo)
> +static inline void init_contrast(struct atmel_lcdfb_info *sinfo)

You really don't need to add manual inlining.  The compiler takes
care of it.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
