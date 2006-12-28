From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.19 1/1] fbdev,
	mm: hecuba/E-Ink fbdev driver v2
Date: Thu, 28 Dec 2006 04:53:13 +0100
Message-ID: <45a44e480612271953we6fe8adg118560161579b7f9@mail.gmail.com>
References: <200612111046.kBBAkV8Y029087@localhost.localdomain>
	<457D895D.4010500@innova-card.com>
	<45a44e480612111554j1450f35ub4d9932e5cd32d4@mail.gmail.com>
	<cda58cb80612130038x6b81a00dv813d10726d495eda@mail.gmail.com>
	<45a44e480612162025n5d7c77bdkc825e94f1fb37904@mail.gmail.com>
	<cda58cb80612200050h6def9866nf1798753da9d842d@mail.gmail.com>
	<cda58cb80612220157q5433c346pccd06b8b7cbaadba@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GzmKQ-0003Xz-R8 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Dec 2006 19:53:14 -0800
Received: from an-out-0708.google.com ([209.85.132.251])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GzmKQ-0007uw-FH
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Dec 2006 19:53:14 -0800
Received: by an-out-0708.google.com with SMTP id d40so2006308and
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 27 Dec 2006 19:53:13 -0800 (PST)
In-Reply-To: <cda58cb80612220157q5433c346pccd06b8b7cbaadba@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: linux-mm@kvack.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On 12/22/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>
> Well thinking more about it, this wouldn't work for all cache types.
> For example, if your cache is not a direct maped one, this workaround
> won't work. So this is definitely not a portable solution.
>

From asking peterz on #mm, I think page_mkclean will do the right
thing and call something like flush_cache_page. I think that resolves
the issue which I think you identified where the end symptom on archs
with virtually tagged caches could be a line of pixels written by
userspace through one PTE remain in-cache and therefore "undisplayed"
when the kernel reads through another PTE that may fall on a different
cacheline.

Thanks,
jayakumar

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
