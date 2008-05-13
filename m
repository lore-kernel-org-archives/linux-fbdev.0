From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tridentfb: fix hi-color modes for
	TGUI 9440
Date: Tue, 13 May 2008 09:40:18 -0700
Message-ID: <20080513094018.bd70b467.akpm@linux-foundation.org>
References: <20080513180641.2eeb1f95.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JvxYo-0002mC-Vy for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 May 2008 09:41:07 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JvxYn-0004yC-Im
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 May 2008 09:41:06 -0700
In-Reply-To: <20080513180641.2eeb1f95.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 13 May 2008 18:06:41 +0200 Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> This is patch number 18. A list of previous patches:
> 
> 01 tridentfb-replace-macros-with-functions.patch
> 02 tridentfb-convert-fb_info-into-allocated-one.patch
> 03 tridentfb-move-global-pseudo-palette-into-structure.patch
> 04 tridentfb-move-global-chip_id-into-structure.patch
> 05 tridentfb-move-global-flat-panel-variable-into-structure.patch
> 06 tridentfb-convert-is_blade-and-is_xp-macros-into-functions.patch
> 07 tridentfb-move-global-acceleration-hooks-into-structure.patch
> 08 tridentfb-make-use-of-functions-and-constants-from-the-vgah.patch
> 09 tridentfb-fix-timing-calculations.patch
> 10 tridentfb-use-mmio-access-for-clock-setting.patch
> 11 tridentfb-fix-clock-settings-for-older-trident-96xx-chips.patch
> 12 tridentfb-improve-probe-function.patch
> 13 tridentfb-improved-register-values-on-tgui-9680.patch
> 14 tridentfb-add-tgui-9440-support.patch
> 15 tridentfb-fix-unitialized-pseudo_palette.patch
> 16 tridentfb-improve-check_var-function.patch
> 17 tridentfb-preserve-memory-type-settings.patch

Looks sane.  I presently have:

tridentfb-replace-macros-with-functions.patch
tridentfb-convert-fb_info-into-allocated-one.patch
tridentfb-move-global-pseudo-palette-into-structure.patch
tridentfb-move-global-chip_id-into-structure.patch
tridentfb-move-global-flat-panel-variable-into-structure.patch
tridentfb-convert-is_blade-and-is_xp-macros-into-functions.patch
tridentfb-move-global-acceleration-hooks-into-structure.patch
tridentfb-make-use-of-functions-and-constants-from-the-vgah.patch
tridentfb-fix-timing-calculations.patch
tridentfb-use-mmio-access-for-clock-setting.patch
tridentfb-fix-clock-settings-for-older-trident-96xx-chips.patch
tridentfb-improve-probe-function.patch
tridentfb-improved-register-values-on-tgui-9680.patch
tridentfb-add-tgui-9440-support.patch
tridentfb-fix-unitialized-pseudo_palette.patch
tridentfb-improve-check_var-function.patch
tridentfb-preserve-memory-type-settings.patch
tridentfb-fix-hi-color-modes-for-tgui-9440.patch


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
