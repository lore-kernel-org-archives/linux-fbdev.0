From: <JosephChan@via.com.tw>
Subject: Re: [PATCH 6/9] viafb: VIA Frame Buffer Device
	Driver
Date: Thu, 8 May 2008 08:54:49 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F67843@exchtp03.taipei.via.com.tw>
References: <20080507162118.45ba52bb@core>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0992248402=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtuPO-0004vL-1K for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 17:54:56 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JtuPM-0001Mu-L0
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 17:54:54 -0700
Content-class: urn:content-classes:message
In-Reply-To: <20080507162118.45ba52bb@core>
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
To: alan@lxorguk.ukuu.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org

--===============0992248402==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="Big5"
Content-Transfer-Encoding: quoted-printable

Hi Alan,

Thanks for your reviewing,=20
I will push our engineers to check those things your mentioned and =
suggested.

BRs,
Joseph Chan=20

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]=20
Sent: Wednesday, May 07, 2008 11:21 PM
To: Joseph Chan
Cc: Joseph Chan; akpm@linux-foundation.org; geert@linux-m68k.org; =
linux-fbdev-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [PATCH 6/9] viafb: VIA Frame Buffer =
Device Driver

> +void delays(int count);
> +void i2cWriteSdaScl(u8 sda, u8 scl);
> +void i2cWriteScl(u8 scl);
> +void i2cReadSdaScl(u8 *pSda, u8 *pScl);

Style is good, code looks clean

One big thing that needs fixing here is the function names. If the =
driver gets linked into the kernel then the symbols become global - and =
names like enableGPIO are asking for clashes. The viafb code is fine as =
it uses viafb_ as the function names. Possibly the helper functions =
should doo something similar.

We also have a generic i2c layer that might be usable but that is =
something that could be addressed in the future and isn't really an =
important detail.

>



--===============0992248402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============0992248402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0992248402==--
