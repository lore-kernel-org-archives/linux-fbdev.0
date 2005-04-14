From: Miles Lane <miles.lane@gmail.com>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives black screen
Date: Thu, 14 Apr 2005 11:19:45 -0700
Message-ID: <a44ae5cd05041411194c3914b1@mail.gmail.com>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com>
	 <20050324203118.345c6004.akpm@osdl.org>
	 <200504141351.42971.adaplas@hotpop.com>
	 <20050414191323.10d7d435.khali@linux-fr.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DM8wX-0003yV-RY
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Apr 2005 11:19:57 -0700
Received: from wproxy.gmail.com ([64.233.184.206])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DM8wW-0005dg-2m
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Apr 2005 11:19:57 -0700
Received: by wproxy.gmail.com with SMTP id 69so502056wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 14 Apr 2005 11:19:46 -0700 (PDT)
In-Reply-To: <20050414191323.10d7d435.khali@linux-fr.org>
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
To: Jean Delvare <khali@linux-fr.org>
Cc: "Antonino A. Daplas" <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

Perhaps I am mistaken, but I thought Andrew wanted to see the nvidiafb
driver work with a default X86 kernel configuration (which allows for
up to 128M to be allocated).  Is the driver attempting to allocate
exactly 128M because that is how much video ram is present in my video
card?

If lots of video cards exist that have more than 128M of video ram,
won't we be seeing many boot problems with the default kernel
configuration?  Does this point to a problem in the kernel design?  Is
this limitation in the kernel's default configuration advantageous?

Thanks,
       Miles


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
