From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 24 Nov 2010 06:25:58 +0000
Subject: Re: [PATCH] video: arcfb: fix buffer overflow
Message-Id: <20101124062558.GF11705@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1290361202-15065-1-git-send-email-segoon@openwall.com>
In-Reply-To: <1290361202-15065-1-git-send-email-segoon@openwall.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: kernel-janitors@vger.kernel.org, Jaya Kumar <jayalk@intworks.biz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Nov 21, 2010 at 08:40:01PM +0300, Vasiliy Kulikov wrote:
> (count + p) is not checked for integer overflow.  If p < fbmemlength
> and count = (size_t)(1 - p) (very big unsigned integer) then
> count + p = 1 < fbmemlength and copy_to_user(base_addr+p, buf, count)
> overflows base_addr.
> 
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>

Applied, thanks.
