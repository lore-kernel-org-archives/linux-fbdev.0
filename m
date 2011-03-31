From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 31 Mar 2011 04:54:23 +0000
Subject: Re: [PATCH] efifb: support AMD Radeon HD 6490
Message-Id: <20110331045409.GB15486@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301530342.2140.2.camel@offworld>
In-Reply-To: <1301530342.2140.2.camel@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Davidlohr Bueso <dave@gnu.org>
Cc: Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, zeus@gnu.org

On Wed, Mar 30, 2011 at 09:12:22PM -0300, Davidlohr Bueso wrote:
> This patch enables the framebuffer for the AMD Radeon 6490 found in the new MacBook Pro 8,2 generation.
> The framebuffer's base is located at 0x90010000, the method for obtaining it was found in the same way mentioned in https://patchwork.kernel.org/patch/91704/
> 
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> Signed-off-by: Jonathan Gonzalez <zeus@gnu.org>

Applied, thanks.
