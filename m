From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Do set var even if no
 fb_check_var() provided.
Date: Wed, 27 Aug 2008 09:08:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808270855110.7910@anakin>
References: <48B4E16C.4000107@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYF8c-0003RC-5T for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 00:08:18 -0700
Received: from nelson.telenet-ops.be ([195.130.133.66])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYF8a-0008Sz-Gh
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 00:08:18 -0700
In-Reply-To: <48B4E16C.4000107@renesas.com>
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
To: Takashi Yoshii <yoshii.takashi@renesas.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 27 Aug 2008, Takashi Yoshii wrote:
> The behavior of FBIOSET_VSCREENINFO seems to be weired on FB which does not
>  provides fbops->fb_check_var.
> It doesn't set anything, but gets info->var instead, and returns no error.
> It is just same as FBIOGET_VSCREENINFO does.
> 
> IMHO, this should be one of the following candidates,
>  1. set var without check.
>  2. do nothing but return error (setting var is not supported).
> or
>  3. it's a bug (fb_check_var should always be provided).
> 
> The patch at the bottom implements "1".
> 
> Because I don't know API specification, nor the history of the code, 
> I would like people who knows well to discuss this.

If the driver doesn't provide a fb_check_var(), it means it cannot
change video mode. Hence this rules out #1.

#2 is not acceptable, as it will break existing applications. It's also
incorrect, as FBIOPUT_VSCREENINFO should succeed for supported modes.
For unsupported modes, the mode should be rounded up to a supported mode, if
possible. In the case of drivers that support one fixed mode only, this
rounding up is relaxed to `rounding' to the sole supported mode.

#3 is also wrong, as fb_check_var() has been deliberately made optional to
simplify drivers that support one fixed mode only.

Conclusion: nothing should be changed?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
