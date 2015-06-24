From: "Gujulan Elango, Hari Prasath (H.)" <hgujulan@visteon.com>
Date: Wed, 24 Jun 2015 16:32:38 +0000
Subject: Re: [PATCH] staging: sm750fb: convert pr_err to pr_info
Message-Id: <20150624163235.GB2931@krrish>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150618125052.GA21893@IND12F0122>
In-Reply-To: <20150618125052.GA21893@IND12F0122>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Jun 22, 2015 at 06:15:06PM +0300, Dan Carpenter wrote:
> On Thu, Jun 18, 2015 at 12:56:54PM +0000, Gujulan Elango, Hari Prasath (H.) wrote:
> > From: Hari Prasath Gujulan Elango <hgujulan@visteon.com>
> > 
> > This patch modifies few debug prints from pr_err() to pr_info() as they
> > fall under that category.
> > 
> 
> They should be dbg or removed.
> 
> regards,
> dan carpenter
> 

Dan,Greg has already merged this patch.Should I now send another patch
to convert this from pr_info() to pr_dbg() ?

Regards
Hari Prasath