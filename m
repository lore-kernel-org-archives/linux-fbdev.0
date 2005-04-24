From: Miles Lane <miles.lane@gmail.com>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives black screen
Date: Sun, 24 Apr 2005 13:09:42 -0400
Message-ID: <a44ae5cd05042410092055e3c4@mail.gmail.com>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com>
	 <200504141351.42971.adaplas@hotpop.com>
	 <20050414191323.10d7d435.khali@linux-fr.org>
	 <200504151107.49810.adaplas@hotpop.com>
	 <a44ae5cd05041601211c292316@mail.gmail.com>
	 <a44ae5cd05042022512e840cfa@mail.gmail.com>
	 <20050421092215.3e6d8be4.rddunlap@osdl.org>
	 <20050421113645.4768967d.rddunlap@osdl.org>
	 <a44ae5cd05042217031c6fbbf5@mail.gmail.com>
	 <a44ae5cd05042217122613bac4@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPkcD-0001wB-Ez
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Apr 2005 10:09:53 -0700
Received: from wproxy.gmail.com ([64.233.184.194])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DPkcD-0005QD-0t
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Apr 2005 10:09:53 -0700
Received: by wproxy.gmail.com with SMTP id 69so1070141wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 24 Apr 2005 10:09:42 -0700 (PDT)
In-Reply-To: <a44ae5cd05042217122613bac4@mail.gmail.com>
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
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net, khali@linux-fr.org, akpm@osdl.org

On 4/22/05, Miles Lane <miles.lane@gmail.com> wrote:
> Okay, it also fails with Antonio's patches applied in addition to yours.

I know I implied this in my previous message, but I want to make it explici=
t.
This combination of patches also fails to give a working framebuffer
console when I specify vmalloc=3D128M.  I only get a working framebuffer
console by specifying vmalloc=3D256M.

           Miles


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
