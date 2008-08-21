From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/13 v2] viafb: accel.c, accel.h
Date: Thu, 21 Aug 2008 09:36:54 -0700
Message-ID: <20080821093654.4947f140.akpm@linux-foundation.org>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078B698F@exchtp03.taipei.via.com.tw>
	<20080819162303.5fc89c63.akpm@linux-foundation.org>
	<C80EF34A3D2E494DBAF9AC29C7AE4EB8285FDD@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KWDAL-00011W-8m for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Aug 2008 09:37:41 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KWDAK-0000Ys-W1
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Aug 2008 09:37:41 -0700
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8285FDD@exchtp03.taipei.via.com.tw>
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
To: JosephChan@via.com.tw
Cc: geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Thu, 21 Aug 2008 22:30:57 +0800 <JosephChan@via.com.tw> wrote:

> Hi Andrew,
>  
> It's our carelessness to check with x86_64 version. And thanks for reminding this.
> The 
>  
>  
> >due to things like this:
> >
> >        MMIO_OUT32(VIA_REG_DSTBASE,
> >                   ((u32) (info->screen_base) - (u32) viafb_FB_MM) >> 3);
> >
> >now, we could just shut the warnings up by casting to (long) instead.
> 
> >But I wonder what's going on in there.  ->screen_base came from
> >ioremap_nocache() and AFAIK there's no guarantee that this virtual
> >address will be less than 4G on 64-bit machines?
> 
> 
> >If the !VIA_MMIO code has no valid use then please just remove it.
> >
> >The VIA_MMIO!=0 macros inplicitly reference a local variable which is
> >the kind of dopey programming trick which should not be performed in
> >new code.  It would be much better to do
> >
> >static inline void via_writel(struct viafb_par *viaparinfo, int reg, u32 val)
> >{
> >        writel(val, viaparinfo->io_virt + reg);
> >}
> >
> >and use that everywhere.
> >
> >It would also be quite acceptable to simply open-code the
> >
> >        writel(val, viaparinfo->io_virt + reg);
> >
> >at all callsites.
> >
> >Those macros may have made it easier to _write_ the code, but they make
> >it harder to _read_ it.  That's a wrong tradeoff.
> 
> Yes, the code seems to be cleaner after removing the macro. 
> We define this macro for convenient debugging originally 
> (MMIO couldn't work due to some wired reason, we can 
> transfer to PORT easily by changing VIA_MMIO=0). 
> It is a real tradeoff.

ok.

> If necessary, we could modify this patch by following your
> suggestions. 
> Should we do that? or they're already done by you?

An incremental patch against the previous patches would be best, please.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
