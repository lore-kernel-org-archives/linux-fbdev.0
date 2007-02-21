From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 2.6.20 1/1] fbdev,
	mm: hecuba/E-Ink fbdev driver
Date: Wed, 21 Feb 2007 18:22:58 -0500
Message-ID: <45a44e480702211522q6225d4fbx3f7d99fcef5fe93c@mail.gmail.com>
References: <20070217104215.GB25512@localhost> <1171715652.5186.7.camel@lappy>
	<45a44e480702170525n9a15fafpb370cb93f1c1fcba@mail.gmail.com>
	<20070217135922.GA15373@linux-sh.org>
	<45a44e480702180331t7e76c396j1a9861f689d4186b@mail.gmail.com>
	<20070218235741.GA22298@linux-sh.org>
	<45a44e480702192013s7d49d05ai31e576f0448a485e@mail.gmail.com>
	<Pine.LNX.4.62.0702200906070.2082@pademelon.sonytel.be>
	<45a44e480702210855t344441c1xf8e081c82ece4e63@mail.gmail.com>
	<Pine.LNX.4.64.0702212151190.20620@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK0nf-0000tf-5d for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 15:23:03 -0800
Received: from ug-out-1314.google.com ([66.249.92.175])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HK0ne-0001U9-N2
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 15:23:03 -0800
Received: by ug-out-1314.google.com with SMTP id z38so1147301ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 21 Feb 2007 15:22:58 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0702212151190.20620@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Paul Mundt <lethal@linux-sh.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On 2/21/07, James Simmons <jsimmons@infradead.org> wrote:
>
> Could you make it work without the framebuffer. There are embedded LCD
> displays that have internal memory that need data flushed to them.
>

I'm not sure I understand. What the current implementation does is to
use host based framebuffer memory. Apps mmap that memory and draw to
that. Then after the delay, that framebuffer is written to the
device's memory. That's the scenario for hecubafb where the Apollo
controller maintains it's own internal framebuffer.

When you say without the framebuffer, if you meant without the host
memory, then this method doesn't work. If you mean without the
device's internal memory, then yes, I think we can do that, because it
would be up to the driver to use the touched pagelist to then perform
IO as suitable for its device.

Thanks,
jaya

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
