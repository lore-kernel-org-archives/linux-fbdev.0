From: Anatolij Gustschin <agust@denx.de>
Date: Mon, 14 Nov 2011 00:15:10 +0000
Subject: Re: Getting FB to work in Console
Message-Id: <20111114011510.3762f4f4@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
In-Reply-To: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello David,

On Sun, 13 Nov 2011 22:50:05 -0500 (EST)
David J Ring Jr <n1ea@arrl.net> wrote:
...
> Here is lspci:
> 
> 00:00.0 Host bridge: Intel Corporation Mobile 4 Series Chipset Memory Controller Hub (rev 07)
> 00:02.0 VGA compatible controller: Intel Corporation Mobile 4 Series Chipset Integrated Graphics Controller (rev 07)
> 00:02.1 Display controller: Intel Corporation Mobile 4 Series Chipset Integrated Graphics Controller (rev 07)

So, you have an Intel GMA 4500MHD. It should be supported
by the i915 driver, I think.

Anatolij
