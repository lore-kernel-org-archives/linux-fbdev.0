From: Miles Lane <miles.lane@gmail.com>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives black screen
Date: Mon, 28 Mar 2005 16:56:38 -0800
Message-ID: <a44ae5cd0503281656592e6177@mail.gmail.com>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com>
	 <20050324203118.345c6004.akpm@osdl.org>
	 <a44ae5cd050325205012399ccc@mail.gmail.com>
	 <42483B11.6010203@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DG52M-0008MG-OE
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Mar 2005 16:56:54 -0800
Received: from wproxy.gmail.com ([64.233.184.196])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DG52L-0003Nw-CJ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Mar 2005 16:56:54 -0800
Received: by wproxy.gmail.com with SMTP id 71so702214wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 28 Mar 2005 16:56:47 -0800 (PST)
In-Reply-To: <42483B11.6010203@osdl.org>
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
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, khali@linux-fr.org

On Mon, 28 Mar 2005 09:12:49 -0800, Randy.Dunlap <rddunlap@osdl.org> wrote:

By the why, I don't know why Andrew got dropped from my previous message list.
Also, I thought you were asking these questions of the fbdev and
vidiafb developers.

> I guess that there is some chance that the io_remap_pfn* patches
> are involved with this.  

I am a tester, so I don't have knowledge about this.

> Is there some way to determine exactly which
> io remap kernel calls are involved in "nvidiafb: cannot ioremap FB
> base" ?  

I don't know.  Someone who does, please tell me.  If someone
will tell me how, I'll be happy to gather the information.

> Is that in the exposed source code?  

I have no idea.  How would I find out?

> If so, where is that source code?  

I have no clue.

> If not, can we determine from the binary which calls
> are being made?  

Uhhh.  I have delivered the Oops info and a bunch of other
information.  I have given you whatever I thought might be helpful.  I
need guidance here.

> Or should I just make a io_remap debug patch that
> prints out lots of debug info so that we can track this down?

I thought you would determine this with input from developers.

Your humble tester (remember me from the early USB days?),

      Miles


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
