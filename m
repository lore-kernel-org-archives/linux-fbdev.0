From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: mono, gray and index configs
Date: Thu, 11 Aug 2005 13:36:56 +0800
Message-ID: <42FAE3F8.8080902@gmail.com>
References: <9e47339105081020216574ac7e@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E35lR-0001Sv-Q8
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 22:38:01 -0700
Received: from wproxy.gmail.com ([64.233.184.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E35l6-0007yM-GQ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 22:38:01 -0700
Received: by wproxy.gmail.com with SMTP id i3so288674wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Aug 2005 22:37:30 -0700 (PDT)
In-Reply-To: <9e47339105081020216574ac7e@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jon Smirl <jonsmirl@gmail.com>

Jon Smirl wrote:
> When filling in a fb_var_screeninfo how do I ask for mono, gray and
> index configs? Is is always request length red and green/blue length =
> zero to indicate a mono, gray or index config? Then grayscale is used
> to differentiate gray/mono from indexed?

For pseudocolor (indexed), just indicate all offsets = 0 and all
lengths equal to each other.

For monochrome, usually set bits_per_pixel = 1. (This is however not always
true, as it's possible to have 2-color display with bits_per_pixel > 1).
It's also possible to have mono01, mono10, 1-bit pseudocolor, 1-bit truecolor.
For 1-bit truecolor, you can only use a primary color for the "foreground".
So only one of the rgba will have a length = 1, the rest are zero. For
monochrome/1-bit pseudocolor, it's similar to setting for pseudocolor except
that all the lengths = 1 and offsets = 0.  Currently, we have no way to
specifically request for mono01, mono10, or 1-bit pseudocolor. Just check
for fix->visual afterwards.  

For grayscale, you use whatever format you want but you have to set
var->grayscale to nonzero. (Grayscale just means that r=g=b, for those
drivers that want to emulate grayscale).

For directcolor (indexed) vs truecolor, there is currently no way
to specify which visual you want.  You also have to check for fix->visual
afterwards.

One of the reason I also want this sysfs attribute is because in at
least 1 driver (i810fb), it's possible to choose between truecolor and
directcolor but it uses a hack by checking for the var->nonstd flag.

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
