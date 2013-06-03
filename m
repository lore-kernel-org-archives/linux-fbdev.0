From: Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 03 Jun 2013 20:34:58 +0000
Subject: Re: linux-next: Tree for Jun 3 (fonts.c & vivi)
Message-Id: <51ACFDF2.4040600@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130603163717.a6f78476e57d92fadd6f6a23@canb.auug.org.au>
In-Reply-To: <20130603163717.a6f78476e57d92fadd6f6a23@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media <linux-media@vger.kernel.org>, linux-fbdev@vger.kernel.org

On 06/02/13 23:37, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20130531:
> 


on x86_64:

warning: (VIDEO_VIVI && USB_SISUSBVGA && SOLO6X10) selects FONT_SUPPORT which has unmet direct dependencies (HAS_IOMEM && VT)
warning: (VIDEO_VIVI && FB_VGA16 && FB_S3 && FB_VT8623 && FB_ARK && USB_SISUSBVGA_CON && SOLO6X10) selects FONT_8x16 which has unmet direct dependencies (HAS_IOMEM && VT && FONT_SUPPORT)


drivers/built-in.o: In function `vivi_init':
vivi.c:(.init.text+0x1a3da): undefined reference to `find_font'

when CONFIG_VT is not enabled.

Just make CONFIG_VIDEO_VIVI depend on VT ?


-- 
~Randy
