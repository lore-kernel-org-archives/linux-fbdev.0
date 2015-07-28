From: David Vrabel <david.vrabel@citrix.com>
Date: Tue, 28 Jul 2015 17:16:40 +0000
Subject: Re: [Xen-devel] [PATCH 6/8] video/xen-fbfront: Further s/MFN/GFN clean-up
Message-Id: <55B7B8F8.3050907@citrix.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
 <1438095769-2560-7-git-send-email-julien.grall@citrix.com>
In-Reply-To: <1438095769-2560-7-git-send-email-julien.grall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julien Grall <julien.grall@citrix.com>, xen-devel@lists.xenproject.org
Cc: linux-fbdev@vger.kernel.org, ian.campbell@citrix.com, stefano.stabellini@eu.citrix.com, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Vrabel <david.vrabel@citrix.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On 28/07/15 16:02, Julien Grall wrote:
> The PV driver xen-fbfront is only dealing with GFN and not MFN. Rename
> all the occurence of MFN to GFN.
> 
> Also take the opportunity to replace to usage of pfn_to_gfn by
> page_to_pfn.

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

David
