From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [atyfb] No display on Sparc Ultra 10 with kernel 2.6.10-rc2 or later
Date: Fri, 18 Feb 2005 05:30:39 +0800
Message-ID: <200502180530.41332.adaplas@hotpop.com>
References: <200502140251.00645.aragorn@tiscali.nl> <200502170724.36195.adaplas@hotpop.com> <200502171516.14390.aragorn@tiscali.nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1tEh-0007MM-9i
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 13:30:59 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D1tEf-0001hl-G5
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 13:30:59 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 646D214021F3
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Feb 2005 21:30:42 +0000 (UTC)
In-Reply-To: <200502171516.14390.aragorn@tiscali.nl>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Frans Pop <aragorn@tiscali.nl>, adaplas@pol.net
Cc: "David S. Miller" <davem@davemloft.net>, debian-sparc@lists.debian.org, sparclinux@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Thursday 17 February 2005 22:16, Frans Pop wrote:
> On Thursday 17 February 2005 00:24, Antonino A. Daplas wrote:
> > > Try this patch and let me know.
> > >
> > > video=atyfb:comp_sync:<n>,vert_sync:<n>,hor_sync:<n>
> > >
> > > n = 0 (low), 1 (high)
>
> I've tested with the following combinations:
> - append="video=atyfb:comp_sync:1,1024x768@70"
>   Works perfectly: csync is high and good display.
> - append="video=atyfb:comp_sync:1,hor_sync:1,vert_sync:0,1024x768@70"
>   csync is high, but for some reason not hsync; display is good.

Okay, it seems that overriding the vsync and hsync settings is useless in
atyfb as it has its own algo to do that:

	if(vdisplay < 400) {
		h_sync_pol = 1;
		v_sync_pol = 0;
	} else if(vdisplay < 480) {
		h_sync_pol = 0;
		v_sync_pol = 1;
	} else if(vdisplay < 768) {
		h_sync_pol = 0;
		v_sync_pol = 0;
	} else {
		h_sync_pol = 1;
		v_sync_pol = 1;
	}

I'll trim the patch for csync only.

> - append="video=atyfb:1024x768@70,comp_sync:1"
>   Same results as first test.
>
> The sync settings were checked with 'fbset -i'.
>
> > BTW, the mode string should always be the last parameter, ie;
> >
> > video=atyfb:comp_sync:1,1024x768@70
>
> Hmmm. Wonder why you say that (considering the result of my last test).

My mistake then.  Thanks for verifying.

>
> Should these new options also be documented in Documentation/fb/?

I'll add this and fix a few buglets when I push upstream.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
