From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 27 Jan 2015 13:42:19 +0000
Subject: Re: [PATCH] OMAPDSS: hdmi5: remove unneeded check
Message-Id: <20150127133019.GA25400@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421167620-17290-1-git-send-email-sudipm.mukherjee@gmail.com>
 <54C63606.30002@ti.com>
In-Reply-To: <54C63606.30002@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 26, 2015 at 02:41:42PM +0200, Tomi Valkeinen wrote:
> On 13/01/15 18:46, Sudip Mukherjee wrote:
> > prior to this check we are checking for word_length_16b and if word_length_16b
> > is false then we are returning with -EINVAL.
> > So at this point word_length_16b can only be true.
> 
> True, but it looks to me the code may be extended in the future.
> 
> And if it would be clear that it won't be extended in the future, then
> there's more code changes needed to reflect that (the whole
> word_length_16b can be removed, etc).

you are the author of the code, so you will know if it will be extended .. :)

Sudip
> 
>  Tomi
> 
> 


