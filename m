From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] OMAP: div reaches max_clk_div.
Date: Thu, 12 Feb 2009 11:32:11 +0530
Message-ID: <5d5443650902112202k67304c03m14eba1988676f07@mail.gmail.com>
References: <49933359.4070206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <soni.trilok@gmail.com>) id 1LXUeU-0007Li-NK
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Feb 2009 06:02:22 +0000
Received: from el-out-1112.google.com ([209.85.162.182])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LXUeL-00063T-LF for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Feb 2009 06:02:22 +0000
Received: by el-out-1112.google.com with SMTP id b25so388493elf.1
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 11 Feb 2009 22:02:12 -0800 (PST)
In-Reply-To: <49933359.4070206@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

Hi Roel,

On Thu, Feb 12, 2009 at 1:51 AM, Roel Kluin <roel.kluin@gmail.com> wrote:
> With for(div = 0; div < max_clk_div; div++) { ... } div reaches max_clk_div.
>
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Looks good. Thanks.

Signed-off-by: Trilok Soni <soni.trilok@gmail.com>

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni

------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
