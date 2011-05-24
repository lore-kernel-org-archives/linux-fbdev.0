From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 24 May 2011 09:05:38 +0000
Subject: Re: [PATCH] [resend] video: s3c-fb: correct transparency checking in 32bpp
Message-Id: <20110524090537.GA12015@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306227323-22681-1-git-send-email-jg1.han@samsung.com>
In-Reply-To: <1306227323-22681-1-git-send-email-jg1.han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, May 24, 2011 at 05:55:23PM +0900, Jingoo Han wrote:
> 32bpp means ARGB 8888 in the driver, therfore the transparency length
> and offset should be 8 and 24 respectively. However, the transparency
> length and offset were previously 0, which means that the driver supports
> RGB 888 without alpha blending when 32bpp is used.
> 
> So, the transparency checking in 32bpp is corrected so that the
> transparency length and offset are 8 and 24 respectively.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

On Tue, May 24, 2011 at 05:55:31PM +0900, Jingoo Han wrote:
> This patch adds gpio setup function to resume function to ensure
> gpio used by FIMD IP and LCD panel during a resume.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Curiously the first version appears to have missed patchwork altogether,
and I missed it in my mail folder, too. Applied now, thanks.
