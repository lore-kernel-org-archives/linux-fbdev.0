From: <JosephChan@via.com.tw>
Subject: Re: [PATCH 1/13 v2] viafb: viafb.modes,
	viafb.txt
Date: Mon, 11 Aug 2008 20:07:03 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078F49C6@exchtp03.taipei.via.com.tw>
References: <Pine.LNX.4.64.0808081724210.420@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSWB0-00076D-Nl for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Aug 2008 05:07:06 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KSWB0-0000sM-9M
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Aug 2008 05:07:06 -0700
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0808081724210.420@anakin>
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
To: geert@linux-m68k.org
Cc: akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hi Geert,

> Please send an incremental patch.
Do you mean that I can send a signle patch for fixing this issue. (v2 -> v3)
And the subject of this mail should be " [PATCH 1/13 v3] viafb: viafb.modes, viafb.txt"
Thanks.

BRs,
Joseph Chan 
-----Original Message-----
From: geert@linux-m68k.org [mailto:geert@linux-m68k.org] 
Sent: Friday, August 08, 2008 11:25 PM
To: Joseph Chan
Cc: linux-fbdev-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org; akpm@linux-foundation.org
Subject: RE: [PATCH 1/13 v2] viafb: viafb.modes, viafb.txt

On Fri, 8 Aug 2008, JosephChan@via.com.tw wrote:
> It should be my carelessness. The check has been added in viafbdev.c already. 

OK.

> Do I need to re-send the patch for the documentation? Thanks for your reminding.

Please send an incremental patch. Andrew is good in folding ;-)

> 
> 
> 
> On Fri, 8 Aug 2008, JosephChan@via.com.tw wrote:
> > +    4. VX800 2D accelerator hasn't been supported in this driver yet. When
> > +       using driver on VX800, one should add parameter "viafb_accel=0" to
> > +       disable 2D accelerator.
> 
> Can't the driver detect this automatically, and disable the 2D 
> accelerator when running on a VX800?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
