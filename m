From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 30 Jan 2013 20:30:44 +0000
Subject: Re: [RFC 1/4] video: panel: add CLAA101WA01A panel support
Message-Id: <510982F4.9040800@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359514939-15653-1-git-send-email-acourbot@nvidia.com> <1359514939-15653-2-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1359514939-15653-2-git-send-email-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

On 01/29/2013 08:02 PM, Alexandre Courbot wrote:
> Add support for the Chunghwa CLAA101WA01A display panel.

Since this defines a new DT binding, especially since it's for a new
class of device, this patch should be Cc:
devicetree-discuss@lists.ozlabs.org too, next time you post.
