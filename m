From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: Fb rotation 2.6.x
Date: Wed, 16 Mar 2005 05:59:23 -0800 (PST)
Message-ID: <20050316135923.8064.qmail@web53605.mail.yahoo.com>
References: <200503160747.20530.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBZ3b-0004EX-Gt
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 05:59:31 -0800
Received: from web53605.mail.yahoo.com ([206.190.37.38])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DBZ3Z-0006Lk-7r
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 05:59:31 -0800
In-Reply-To: <200503160747.20530.adaplas@hotpop.com>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

--- "Antonino A. Daplas" <adaplas@hotpop.com> wrote:
> Sometimes people use multiple fbdevs mapped to
> different consoles, so a
> set_par() is called for each fb_info mapped for
> each console.

Thanx for the reply. My kernel seems to be old 2.6.9 -
compared to the patches you had supplied me. I should
update my omap242x tree to 2.6.11 atleast. So that it
can cover the all the changes which were went in for
fbcon.

But before that too, I will try to call set_par only
once and update the var info as you had suggested in
the patch , and will let you know about what happens
on LCD panel :-).

---Komal Shah


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
