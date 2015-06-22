From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 22 Jun 2015 15:15:06 +0000
Subject: Re: [PATCH] staging: sm750fb: convert pr_err to pr_info
Message-Id: <20150622151506.GA28762@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150618125052.GA21893@IND12F0122>
In-Reply-To: <20150618125052.GA21893@IND12F0122>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Jun 18, 2015 at 12:56:54PM +0000, Gujulan Elango, Hari Prasath (H.) wrote:
> From: Hari Prasath Gujulan Elango <hgujulan@visteon.com>
> 
> This patch modifies few debug prints from pr_err() to pr_info() as they
> fall under that category.
> 

They should be dbg or removed.

regards,
dan carpenter

--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
