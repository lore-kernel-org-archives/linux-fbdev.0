From: Miles Lane <miles.lane@gmail.com>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives black screen
Date: Sat, 16 Apr 2005 04:21:25 -0400
Message-ID: <a44ae5cd05041601211c292316@mail.gmail.com>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com>
	 <200504141351.42971.adaplas@hotpop.com>
	 <20050414191323.10d7d435.khali@linux-fr.org>
	 <200504151107.49810.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMiYd-0000OC-Pu
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 16 Apr 2005 01:21:39 -0700
Received: from wproxy.gmail.com ([64.233.184.199])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DMiYW-0001Ug-8v
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 16 Apr 2005 01:21:39 -0700
Received: by wproxy.gmail.com with SMTP id 69so867379wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 16 Apr 2005 01:21:26 -0700 (PDT)
In-Reply-To: <200504151107.49810.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>

Hello Tony,

So far no Oops messages while testing your patches to nvidiafb.
I have tried compiling all the I2C drivers into the kernel and then
booting with vesafb as the console graphics driver.  So far it looks
good.  I need to do more careful testing of the case where no
vmalloc=3D is specified.  I'll try to get to this tomorrow.  So far, so goo=
d.

                Miles


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
