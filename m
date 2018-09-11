From: Timur Tabi <timur@kernel.org>
Date: Tue, 11 Sep 2018 03:34:10 +0000
Subject: Re: [PATCH 21/21] fbdev: fsl-diu: get cpu node with of_get_cpu_node
Message-Id: <bc758dcc-c881-ab7e-129f-8a1a1c628daa@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
 <20180905193738.19325-22-robh@kernel.org>
In-Reply-To: <20180905193738.19325-22-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 9/5/18 2:37 PM, Rob Herring wrote:
>   #ifdef CONFIG_NOT_COHERENT_CACHE
> -	np = of_find_node_by_type(NULL, "cpu");
> +	np = of_get_cpu_node(0, NULL);

This #ifdef means that it's only compiled on an MPC5121, which is a very 
dead platform.  of_get_cpu_node() looks okay to me, but I'm going to 
have to assume that you know what you're doing.

Acked-by: Timur Tabi <timur@kernel.org>
