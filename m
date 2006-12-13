From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [RFC 2.6.19 1/1] fbdev,
	mm: hecuba/E-Ink fbdev driver v2
Date: Wed, 13 Dec 2006 09:38:26 +0100
Message-ID: <cda58cb80612130038x6b81a00dv813d10726d495eda@mail.gmail.com>
References: <200612111046.kBBAkV8Y029087@localhost.localdomain>
	<457D895D.4010500@innova-card.com>
	<45a44e480612111554j1450f35ub4d9932e5cd32d4@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GuPdE-0002cR-Rs for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 00:38:28 -0800
Received: from ug-out-1314.google.com ([66.249.92.174])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GuPdD-0001rj-GQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 00:38:28 -0800
Received: by ug-out-1314.google.com with SMTP id z38so106813ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 13 Dec 2006 00:38:27 -0800 (PST)
In-Reply-To: <45a44e480612111554j1450f35ub4d9932e5cd32d4@mail.gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-mm@kvack.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On 12/12/06, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> I think that PTEs set up by vmalloc are marked cacheable and via the
> above nopage end up as cacheable. I'm not doing DMA. So the accesses
> are through the cache so I don't think cache aliasing is an issue for
> this case. Please let me know if I misunderstood.
>

This issue is not related to DMA: there are 2 different virtual
addresses that can map the same physical address. If these 2 virtual
addresses use 2 different data cache entries then you have a cache
aliasing issue. In your case the 2 different virtual addresses are (1)
the one got by the kernel (returned by vmalloc) (2) the one got by the
application (returned by mmap).

Hope that helps.
-- 
               Franck

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
