From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/4] pxafb: preliminary smart panel
	interface support
Date: Tue, 8 Apr 2008 01:23:59 -0700
Message-ID: <20080408012359.d0a7d0c8.akpm@linux-foundation.org>
References: <f17812d70804072107k77c2642ah23c8f2ce9535159f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jj986-0005qe-RP for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Apr 2008 01:24:34 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jj985-0004HA-7z
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Apr 2008 01:24:34 -0700
In-Reply-To: <f17812d70804072107k77c2642ah23c8f2ce9535159f@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: eric miao <eric.y.miao@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel email list <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Mack <daniel@caiaq.de>, lkml <linux-kernel@vger.kernel.org>

On Tue, 8 Apr 2008 12:07:27 +0800 "eric miao" <eric.y.miao@gmail.com> wrote:

> +static int pxafb_smart_thread(void *arg)
> +{
> +	struct pxafb_info *fbi = (struct pxafb_info *) arg;

Please don't typecast when assigning a pointer to or from void*.

Reasons:

- It defeats typechecking: if someone later converts `arg' to a u8, they
  won't even get a compiler warning.

- Improved code readability.


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
