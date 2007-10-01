From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 6/6] Xilinxfb: add of_platform bus
	binding
Date: Mon, 1 Oct 2007 10:46:38 -0600
Message-ID: <fa686aa40710010946s55e3cf19w1e91a4e5c48b3dd6@mail.gmail.com>
References: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
	<20071001155759.6114.29143.stgit@trillian.cg.shawcable.net>
	<961aa3350710010942y42aef8eax6fb54354184b4cc1@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IcOPv-0001Ig-P0 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 09:46:47 -0700
Received: from an-out-0708.google.com ([209.85.132.246])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IcOPt-0000IR-GU
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 09:46:47 -0700
Received: by an-out-0708.google.com with SMTP id b38so668406ana
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 01 Oct 2007 09:46:42 -0700 (PDT)
In-Reply-To: <961aa3350710010942y42aef8eax6fb54354184b4cc1@mail.gmail.com>
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
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: akonovalov@ru.mvista.com, linuxppc@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On 10/1/07, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> 2007/10/2, Grant Likely <grant.likely@secretlab.ca>:
>
> >  static int __init
> >  xilinxfb_init(void)
> >  {
> > -       /*
> > -        * No kernel boot options used,
> > -        * so we just need to register the driver
> > -        */
> > +       int rc;
> > +       rc = xilinxfb_of_register();
> > +       if (rc)
> > +               return rc;
> > +
> >         return platform_driver_register(&xilinxfb_platform_driver);
>
> Is it better to add error handling for platform_driver_register()?

Right, good catch.  I'll fix that

Thanks!
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
