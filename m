From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Re: [PATCH 1/6] nvidiafb: ioremap and i2c
 fixes
Date: Mon, 25 Apr 2005 07:51:53 -0700
Message-ID: <20050425075153.3f4ca6c0.rddunlap@osdl.org>
References: <200504161313.25574.adaplas@hotpop.com>
	<20050423174013.3006852f.akpm@osdl.org>
	<200504251121.20530.adaplas@hotpop.com>
	<20050424220309.77617eed.rddunlap@osdl.org>
	<a44ae5cd0504242236365088ba@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQ4xN-0004q8-Bz
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Apr 2005 07:53:05 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DQ4x3-0005NX-CN
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Apr 2005 07:53:05 -0700
In-Reply-To: <a44ae5cd0504242236365088ba@mail.gmail.com>
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
Cc: miles.lane@gmail.com, adaplas@hotpop.com, akpm@osdl.org, adaplas@pol.net

On Sun, 24 Apr 2005 22:36:42 -0700 Miles Lane wrote:

| On 4/24/05, Randy.Dunlap <rddunlap@osdl.org> wrote:
| > On Mon, 25 Apr 2005 11:21:20 +0800 Antonino A. Daplas wrote:
| > 
| > | On Sunday 24 April 2005 08:40, Andrew Morton wrote:
| > | > "Antonino A. Daplas" <adaplas@hotpop.com> wrote:
| > | > > - Add 'vram' option to specify amount of video RAM to remap
| > | > >  - Limit remap size to 128 MIB
| > | >
| > | > Am I right in believing that if someone has a 256MB card and doesn't know
| > | > about the `vram' option, their card will fail to work, because the 128MB
| > | > vmalloc() will fail?
| > | >
| > |
| > | I thought that a 128MiB vmalloc will work.
| > 
| > The default vmalloc total size is 128 MB, but the kernel always
| > requires a "guard page", which cannot be allocated, so the
| > total allocation fails.
| > 
| > I tried to make a patch that sets the default vmalloc total size
| > to 128 MB + PAGE_SIZE, but Miles reported that the driver's
| > vmalloc() call still failed...
| 
| Which seems to beg a couple of questions:
| How much memory is _really_ trying to get allocated when I boot
| with no vmalloc argument.  Does this point to some problem in 
| the nvidiafb code?  Does the fact that specifying vmalloc=128M
| does not fix the problem indicate that something about my video
| card won't work with less than 256Mb vmalloced, or is this a
| driver issue?

or simply that some other code is also vmalloc-ing some memory,
so that nvidiafb's request can't succeed due to that?

You could go back to the very first test patch that I sent
to you to see if other vmalloc's are happening.  I don't recall
the result of that one, but it seems like it was "Nope."

---
~Randy


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
