From: "Akinobu Mita" <akinobu.mita@gmail.com>
Subject: Re: [PATCH 6/6] Xilinxfb: add of_platform bus binding
Date: Tue, 2 Oct 2007 01:42:27 +0900
Message-ID: <961aa3350710010942y42aef8eax6fb54354184b4cc1@mail.gmail.com>
References: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
	 <20071001155759.6114.29143.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755950AbXJAQmj@vger.kernel.org>
In-Reply-To: <20071001155759.6114.29143.stgit@trillian.cg.shawcable.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, akonovalov@ru.mvista.com, linuxppc@ozlabs.org, adaplas@gmail.com

2007/10/2, Grant Likely <grant.likely@secretlab.ca>:

>  static int __init
>  xilinxfb_init(void)
>  {
> -       /*
> -        * No kernel boot options used,
> -        * so we just need to register the driver
> -        */
> +       int rc;
> +       rc = xilinxfb_of_register();
> +       if (rc)
> +               return rc;
> +
>         return platform_driver_register(&xilinxfb_platform_driver);

Is it better to add error handling for platform_driver_register()?

    rc = platform_driver_register(&xilinxfb_platform_driver);
    if (rc)
        xilinxfb_of_unregister();

    return rc;


>  }
>
> @@ -398,6 +482,7 @@ static void __exit
>  xilinxfb_cleanup(void)
>  {
>         platform_driver_unregister(&xilinxfb_platform_driver);
> +       xilinxfb_of_unregister();
>  }
