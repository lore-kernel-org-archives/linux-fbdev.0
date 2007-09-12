From: "suresh gani" <sureshgani@gmail.com>
Subject: Re: [PATCH] Intel FB pixel clock calculation fix
Date: Wed, 12 Sep 2007 09:47:59 +0530
Message-ID: <9771bb700709112117w19a5be16v869d5326a5ce79a4@mail.gmail.com>
References: <m3ir6il3wl.fsf@maximus.localdomain>
	<20070910225221.f0eaf22c.akpm@linux-foundation.org>
	<m3veah75u6.fsf@maximus.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVJfs-0006R4-Ky for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Sep 2007 21:18:01 -0700
Received: from wa-out-1112.google.com ([209.85.146.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IVJfs-0002wF-9x
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Sep 2007 21:18:00 -0700
Received: by wa-out-1112.google.com with SMTP id k22so104135waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 11 Sep 2007 21:17:59 -0700 (PDT)
In-Reply-To: <m3veah75u6.fsf@maximus.localdomain>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

please send me a source code of framebuffer smaple applicatin program
in embedded systems

On 9/11/07, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> Andrew Morton <akpm@linux-foundation.org> writes:
>
> >> Intel framebuffer mis-calculated pixel clocks.
>
> > and... what are the consequences of this miscalculation?  I need to know
> > such things so that I can decide whether a change is needed in 2.6.23.
> And
> > 2.6.22.
>
> The pixel clock (and thus both H and V sync) will be slower than
> requested, so if you set the minimum allowed the display may not
> sync. In case of really old CRT display it could theoretically
> damage it.
>
> I'm using it with PAL TV (using RGB input - SCART connector) and
> the bug prevented it from working at all (TV requirements are more
> strict and made the bug visible).
>
> I think 2.6.22 would be overkill, .23 - not sure.
> --
> Krzysztof Halasa
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>


-- 
Regards
 SURESH S GANI
    SOFTWARE ENGINEER.
    SPA COMPUTERS PVT LTD.
         -An Embedded Systems Company.
    HAL Second Stage Indiranagar.
    Bangalore-8.
    mob:9902703238

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
