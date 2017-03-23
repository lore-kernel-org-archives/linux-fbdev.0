From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Date: Thu, 23 Mar 2017 14:13:44 +0000
Subject: Re: [PATCH] xen, fbfront: add support for specifying size via xenstore
Message-Id: <ac309068-4d89-4684-0890-4671c2396d61@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170323125304.11891-1-jgross@suse.com>
In-Reply-To: <20170323125304.11891-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org
Cc: b.zolnierkie@samsung.com

On 03/23/2017 08:53 AM, Juergen Gross wrote:
> Today xen-fbfront supports specifying the display size via module
> parameters only. Add support for specifying the size via Xenstore in
> order to enable doing this easily via the domain's Xen configuration.
>
> Add an error message in case the configured display size conflicts
> with video memory size.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


