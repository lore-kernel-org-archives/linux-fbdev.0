From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 08 Jul 2014 05:59:20 +0000
Subject: Re: [PATCH v2] video: fbdev: sis: init.c:  Cleaning up variable that is never used
Message-Id: <20140708055919.GP25934@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404764628-25192-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404764628-25192-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Mauro Carvalho Chehab <m.chehab@samsung.com>, "Chen, Gong" <gong.chen@linux.intel.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 07, 2014 at 10:23:47PM +0200, Rickard Strandqvist wrote:
> Variable ar assigned a value that is never used.
> I have also removed all the code that thereby serves no purpose.
> 
> This was found using a static code analysis program called cppcheck
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

