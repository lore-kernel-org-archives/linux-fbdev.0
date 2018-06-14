From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 14 Jun 2018 16:27:37 +0000
Subject: Re: [PATCH v3 04/27] docs: fix broken references with multiple hints
Message-Id: <20180614122737.4044a2b7@gandalf.local.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
 <8e28c30c9d0ba8c4f37d57adac7e12e18296a385.1528990947.git.mchehab+samsung@kernel.org>
In-Reply-To: <8e28c30c9d0ba8c4f37d57adac7e12e18296a385.1528990947.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org, linux-usb@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Harry Wei <harryxiyou@gmail.com>, devel@driverdev.osuosl.org, Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>, Ingo Molnar <mingo@redhat.com>, linux-input@vger.kernel.org, Roy Pledge <Roy.Pledge@nxp.com>, "Serge E. Hallyn" <serge@hallyn.com>, devicetree@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jiri Kosina <jikos@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, Benjamin Tissoires <ben>

On Thu, 14 Jun 2018 13:08:49 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

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
> index a4d3ff2e5efb..bef37abf4ad3 100644
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

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
