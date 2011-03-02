From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 02 Mar 2011 11:27:52 +0000
Subject: Re: [PATCH 1/2] fbdev: sh_mobile_lcdc: Add YUV input support
Message-Id: <20110302112752.297116dc@lxorguk.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1298456210-26519-1-git-send-email-dhobsong@igel.co.jp>
	<1298456210-26519-2-git-send-email-dhobsong@igel.co.jp>
	<Pine.LNX.4.64.1102231132030.10099@axis700.grange>
	<4D64EDFC.6070203@igel.co.jp>
	<AANLkTi=rKDRbQYzPLHmRj+fEvAgpHzG2HXBwaBZi0vn_@mail.gmail.com>
	<AANLkTikCo9CruLWE5=XjaspnM6CdKhbyPs3rajPLMV0G@mail.gmail.com>
	<AANLkTikpL3m_8YVMiRRRULmB_Px9asdK-Fto07WeyJgG@mail.gmail.com>
	<AANLkTi=Kc6wueQPJrw1ZtAe4qkOrmn1O7eXgF5oze-FP@mail.gmail.com>
	<AANLkTikFPdZ1ER=Cb59LL2CwBTA2NExSiVaTPzbGsE_o@mail.gmail.com>
In-Reply-To: <AANLkTikFPdZ1ER=Cb59LL2CwBTA2NExSiVaTPzbGsE_o@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Corbin Simpson <mostawesomedude@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, matsu@igel.co.jp, linux-fbdev@vger.kernel.org, taki@igel.co.jp, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org, Damian <dhobsong@igel.co.jp>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Tue, 1 Mar 2011 13:31:19 -0800
Corbin Simpson <mostawesomedude@gmail.com> wrote:

> I am slightly curious about this as well; I have a device with only YUV
> scanout and was considering KMS, but don't know what the best approach is.

The problem with hiding behind a fake RGB frame buffer is you've then
completely stuffed any framebuffer based apps that could use YUV happily
(eg framebuffer video playback).

Far better to make the kernel tell the truth in these cases. You'll need
to add some tweaks to the fb code for it and a YUV boot penguin.[1]

If you want to run X on it then you can use shadowfb on the X side to do
your YUV/RGB adaptation.

Alan
--
[1] Am I the only one who thinks the fb code also needs an imagine of an
embarassed penguin that has wet itself to go with oops output ?
