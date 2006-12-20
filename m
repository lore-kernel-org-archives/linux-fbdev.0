From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [RFC 2.6.19 1/1] fbdev,
	mm: hecuba/E-Ink fbdev driver v2
Date: Wed, 20 Dec 2006 09:50:46 +0100
Message-ID: <cda58cb80612200050h6def9866nf1798753da9d842d@mail.gmail.com>
References: <200612111046.kBBAkV8Y029087@localhost.localdomain>
	<457D895D.4010500@innova-card.com>
	<45a44e480612111554j1450f35ub4d9932e5cd32d4@mail.gmail.com>
	<cda58cb80612130038x6b81a00dv813d10726d495eda@mail.gmail.com>
	<45a44e480612162025n5d7c77bdkc825e94f1fb37904@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GwxA2-0001WV-Qt for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Dec 2006 00:50:50 -0800
Received: from ug-out-1314.google.com ([66.249.92.169])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GwxA0-0000Cj-8H
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Dec 2006 00:50:50 -0800
Received: by ug-out-1314.google.com with SMTP id z38so2020422ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 20 Dec 2006 00:50:46 -0800 (PST)
In-Reply-To: <45a44e480612162025n5d7c77bdkc825e94f1fb37904@mail.gmail.com>
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

On 12/17/06, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> Ok. I now see what you mean. In typical cases, only one path is used
> to write. Meaning an app will decide to use the mmap path or the slow
> write path and the kernel only ever reads from its pte entry (unless
> fbcon is used which is not suited for this type of display).

Even if the kernel does only reads, you can be in trouble. For
example, the kernel access (by reading) to a data A through the cache
line 1. The application access (by writing a new value) data A through
the cahe line 5. Now it's time to update your frame buffer, so the
kernel access to data A through the cache line 1 which still contains
the _stall_ value.

Note that flushing data  before the kernel access it does not solve
any problems. If the kernel is allowed to write into the frame buffer,
the kernel don't know which line stores the up to date data...

> But you
> are right that it is possible for a situation to arise where one app
> does mmap and another is doing write.

I would say that should be a safe case. Nornally the kernel takes care
to flush caches between context switches (depending on your cache
architecture). But it's only a guess, I haven't checked the code...

> My hope is that something takes
> care of flushing the data cache for me in this case. Do you recommend
> I add something to force that?

Well I'm not the right person to answer this question. I haven't
looked at how Linux handles cache consistency yet. Knowing that I can
give you only 2 recommandations:

    - disable the cache when accessing your frame buffer (kernel and
applications).

    - when mmaping your frame buffer , be sure that the virtual
address returned by
      mmap() to the application shares the same cache lines than the
ones the kernel
      is using.

Hoping it helps,
-- 
               Franck

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
