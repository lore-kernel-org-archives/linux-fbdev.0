From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Re: radeon, apertures & memory mapping
Date: Sun, 13 Mar 2005 23:40:44 -0500
Message-ID: <9e47339105031320407b3b6bcd@mail.gmail.com>
References: <20050313082216.GA7362@sci.fi> <1110750553.5787.155.camel@gaston>
	 <9e47339105031314101c89e50e@mail.gmail.com>
	 <1110752401.19810.177.camel@gaston>
	 <9e47339105031315002a444f00@mail.gmail.com>
	 <16948.56755.114690.200854@cargo.ozlabs.ibm.com>
	 <20050314005613.GA21434@sci.fi> <1110762359.19810.209.camel@gaston>
	 <9e47339105031317474b9a6234@mail.gmail.com>
	 <16949.3582.867897.542158@cargo.ozlabs.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAhOI-0001wz-EO
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 20:41:18 -0800
Received: from rproxy.gmail.com ([64.233.170.194])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAhOI-0005Ms-0v
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 20:41:18 -0800
Received: by rproxy.gmail.com with SMTP id z35so3067414rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Mar 2005 20:40:44 -0800 (PST)
In-Reply-To: <16949.3582.867897.542158@cargo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net

On Mon, 14 Mar 2005 15:07:26 +1100, Paul Mackerras <paulus@samba.org> wrote:
> xorg@lists.freedesktop.org removed from CC since I can't post to it.
> 
> Jon Smirl writes:
> 
> > It shouldn't hurt to have a parallel non-cached mapping being used in
> > conjuction with this protocol. By definition the non-cached mapping
> > never gets into an inconsistent state.
> 
> According to the PowerPC Architecture specification, it is a
> programming error to have both cacheable and uncacheable mappings of
> the same page.  That means the hardware designers consider that they
> don't have to worry if the hardware misbehaves if software does
> that. :P  So that is not a feasible solution for us.
> 
> Paul.

Ok, I see this is a problem for the PPC. I've never used a PPC so you
guys have to tell me what is illegal on it.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
