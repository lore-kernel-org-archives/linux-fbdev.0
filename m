From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Running fb core as a module
Date: Thu, 17 Feb 2005 18:08:37 -0500
Message-ID: <9e473391050217150813fea994@mail.gmail.com>
References: <9e473391050216173115f37838@mail.gmail.com>
	 <Pine.LNX.4.56.0502172214350.10099@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1ulI-0005PD-SZ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 15:08:44 -0800
Received: from rproxy.gmail.com ([64.233.170.201])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D1ulI-0000cp-Ey
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 15:08:44 -0800
Received: by rproxy.gmail.com with SMTP id z35so482274rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Feb 2005 15:08:38 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0502172214350.10099@pentafluge.infradead.org>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Thu, 17 Feb 2005 22:16:36 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> 
> > Is there a patch floating around for turning the core of fbdev into a
> > module? Why isn't running fbdev as a module an option? It would make
> > debugging fbdev core much simpler.
> 
> I agree. Of course you would need either a graphics card boot from a non
> primary slot or work with serial console :-) Of course that opens alot of
> other issues with races. We have to look into it in depth.

I am using 2 graphics cards. I run X on the primary one and test
DRM/fbdev on the secondary one.

What would cause races? the base fb system is inactive unless you load
something that uses it like fbconsole. Look in the patch I sent, the
code for doing this is minor.


> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 


-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
