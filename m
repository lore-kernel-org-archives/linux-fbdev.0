From: H Hartley Sweeten <hartleys@visionengravers.com>
Date: Fri, 16 Nov 2012 16:44:09 +0000
Subject: RE: [RFC] fbdev: arm has __raw I/O accessors, use them in fb.h
Message-Id: <ADE657CA350FB648AAC2C43247A983F00206B2644F3F@AUSP01VMBX24.collaborationhost.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353057364-21214-1-git-send-email-archit@ti.com>
In-Reply-To: <1353057364-21214-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday, November 16, 2012 2:16 AM, Archit Taneja wrote:
>
> This removes the sparse warnings on arm platforms:
>
> warning: cast removes address space of expression
>
> Signed-off-by: Archit Taneja <archit@ti.com>

I submitted the same patch around early March 2012. So FWIW:

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Regards,
Hartley
