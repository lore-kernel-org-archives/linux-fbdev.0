From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [RFC 2.6.19 1/1] fbdev,
	mm: hecuba/E-Ink fbdev driver v2
Date: Fri, 22 Dec 2006 10:57:31 +0100
Message-ID: <cda58cb80612220157q5433c346pccd06b8b7cbaadba@mail.gmail.com>
References: <200612111046.kBBAkV8Y029087@localhost.localdomain>
	<457D895D.4010500@innova-card.com>
	<45a44e480612111554j1450f35ub4d9932e5cd32d4@mail.gmail.com>
	<cda58cb80612130038x6b81a00dv813d10726d495eda@mail.gmail.com>
	<45a44e480612162025n5d7c77bdkc825e94f1fb37904@mail.gmail.com>
	<cda58cb80612200050h6def9866nf1798753da9d842d@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gxh9h-0004r3-RO for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 Dec 2006 01:57:34 -0800
Received: from ug-out-1314.google.com ([66.249.92.174])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gxh9h-0003Co-Ez
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 Dec 2006 01:57:33 -0800
Received: by ug-out-1314.google.com with SMTP id z38so2843494ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 22 Dec 2006 01:57:32 -0800 (PST)
In-Reply-To: <cda58cb80612200050h6def9866nf1798753da9d842d@mail.gmail.com>
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

On 12/20/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:

>     - when mmaping your frame buffer , be sure that the virtual
>       address returned by mmap() to the application shares the
>       same cache lines than the ones the kernel
>       is using.

Well thinking more about it, this wouldn't work for all cache types.
For example, if your cache is not a direct maped one, this workaround
won't work. So this is definitely not a portable solution.

-- 
               Franck

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
