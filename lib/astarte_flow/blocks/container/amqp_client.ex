#
# This file is part of Astarte.
#
# Copyright 2020 Ispirata Srl
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

defmodule Astarte.Flow.Blocks.Container.AMQPClient do
  @moduledoc false

  alias AMQP.{Basic, Channel}

  @typep config :: term()
  @typep block_type :: :producer | :consumer | :producer_consumer

  @callback generate_config(opts :: any) :: {:ok, config} | {:error, any}
  @callback setup(config, block_type) :: {:ok, map()} | {:error, any}
  @callback publish(
              channel :: Channel.t(),
              exchange :: binary(),
              routing_key :: binary(),
              payload :: binary(),
              opts :: keyword()
            ) :: :ok | {:error, reason :: term()}
  @callback ack(channel :: Channel.t(), delivery_tag :: Basic.delivery_tag()) :: any
  @callback reject(
              channel :: Channel.t(),
              delivery_tag :: Basic.delivery_tag(),
              opts :: keyword
            ) :: any
  @callback consume(channel :: Channel.t(), queue :: binary()) :: Basic.consumer_tag()
  @callback close_connection(conn :: Connection.t()) :: :ok | {:error, any}
end
