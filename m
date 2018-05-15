From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 15 May 2018 14:52:28 +0000
Subject: Re: [PATCH v2 11/11] docs: fix broken references with multiple hints
Message-Id: <20180515105228.4ac2df94@gandalf.local.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
 <63a4f8a93f9115475bc184d0f37d076c9b9c75ff.1525870886.git.mchehab+samsung@kernel.org>
In-Reply-To: <63a4f8a93f9115475bc184d0f37d076c9b9c75ff.1525870886.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org, linux-usb@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, David Airlie <airlied@linux.ie>, Linus Walleij <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org, Harry Wei <harryxiyou@gmail.com>, devel@driverdev.osuosl.org, Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>, Ingo Molnar <mingo@redhat.com>, linux-input@vger.kernel.org, Roy Pledge <Roy.Pledge@nxp.com>, devicetree@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jiri Kosina <jikos@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, Benjamin

On Wed,  9 May 2018 10:18:54 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:


> diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> index 7b6b1236ec2e..c292117b83a9 100644
> --- a/Documentation/trace/events.rst
> +++ b/Documentation/trace/events.rst
> @@ -8,7 +8,7 @@ Event Tracing
>  1. Introduction
>  =======>  
> -Tracepoints (see Documentation/trace/tracepoints.txt) can be used
> +Tracepoints (see Documentation/trace/tracepoints.rst) can be used
>  without creating custom kernel modules to register probe functions
>  using the event tracing infrastructure.
>  
> diff --git a/Documentation/trace/tracepoint-analysis.rst b/Documentation/trace/tracepoint-analysis.rst
> index b0c9c21f129d..716326b9f152 100644
> --- a/Documentation/trace/tracepoint-analysis.rst
> +++ b/Documentation/trace/tracepoint-analysis.rst
> @@ -6,7 +6,7 @@ Notes on Analysing Behaviour Using Events and Tracepoints
>  1. Introduction
>  =======>  
> -Tracepoints (see Documentation/trace/tracepoints.txt) can be used without
> +Tracepoints (see Documentation/trace/tracepoints.rst) can be used without
>  creating custom kernel modules to register probe functions using the event
>  tracing infrastructure.
>  

> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index c94f466d57ef..19a690b559ca 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -4,7 +4,7 @@
>  /*
>   * Kernel Tracepoint API.
>   *
> - * See Documentation/trace/tracepoints.txt.
> + * See Documentation/trace/tracepoints.rst.
>   *
>   * Copyright (C) 2008-2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
