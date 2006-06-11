From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file
	describing the feature
Date: Sun, 11 Jun 2006 12:36:22 +0800
Message-ID: <448B9DC6.8030109@gmail.com>
References: <44893407.4020507@gmail.com> <448AC8BE.7090202@gmail.com>	
	<9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>	
	<448B38F8.2000402@gmail.com>	
	<9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>	
	<448B61F9.4060507@gmail.com>	
	<9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>	
	<448B6ED3.5060408@gmail.com>	
	<9e4733910606101905y6bfdff4bo3c1b1a2126d02b26@mail.gmail.com>	
	<448B8818.1010303@gmail.com>
	<9e4733910606102027o8438d55webf938dfc8495ea8@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FpHgi-0004Eu-OH for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 21:36:36 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FpHgi-0002B0-GI for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 21:36:36 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FpHgh-0001Zm-5j
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 21:36:36 -0700
Received: by py-out-1112.google.com with SMTP id x31so1355845pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 10 Jun 2006 21:36:33 -0700 (PDT)
In-Reply-To: <9e4733910606102027o8438d55webf938dfc8495ea8@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Jon Smirl wrote:
> On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> My point is: 'Multiple active drivers feature' is a natural consequence
>> of the evolution of the code, but the only way to take advantage of it
>> is if we provide a means for the user to use it.  And we are not
>> providing the means.
> 
> I'd rather not provide the means and defer this capability to a user
> space implementation where we can achieve true multi-user,
> multi-adapter and multi-head support. The more features we add to the
> VT layer today, the harder it will be to replace it in the future.

No, I'm not adding any new features.  We have bind capability, the only
added feature is unbind, that's it.

> 
> I'd like to keep the sysfs attributes as simple as possible because if
> they get too complex and flexible no one is going to know how to set
> them. But you're writing the code and you'll do what you think is
> best.

I'm just trying to evolve the code, with the least amount or no breakage.
There's nothing revolutionary here.

Tony
